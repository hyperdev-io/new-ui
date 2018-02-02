const React                 = require('react');
const {withState}  = require('recompose');
const { Button, Layer, Form, Header, Heading, Paragraph, FormFields, FormField, Footer, TextInput } = require('grommet');

const withName = withState('newBucketName', 'setNewBucketName', '');

module.exports = withName(({hidden, selectedBucket, newBucketName, setNewBucketName, onClose, onSubmit}) => {
  const _onDOMChange = evt => setNewBucketName(evt.target.value);
  const _onClose = function() { setNewBucketName(''); return onClose(); };
  const _onSubmit = () => typeof onSubmit === 'function' ? onSubmit(selectedBucket, newBucketName) : undefined;

  return (
    <Layer onClose={_onClose} align='right' closer={true} hidden={hidden}>
      <Form>
        <Header pad={{vertical: 'medium'}}><Heading>Copy</Heading></Header>
        <FormFields>
          <Paragraph>Copy the data from <strong>{selectedBucket}</strong> to a newly created bucket.</Paragraph>
          <FormField label="New bucket name">
            <TextInput autoFocus placeHolder={`Copy of ${selectedBucket}`}
              onDOMChange={_onDOMChange}
              onSelect={({suggestion}) => setNewBucketName(suggestion)}
              value={newBucketName} />
            </FormField>
        </FormFields>
        <Footer pad={{vertical:'medium'}} justify='between' align='center'>
          <Button onClick={_onSubmit} primary={true} label='Copy' />
          <Button onClick={_onClose} plain={true} label='Cancel' />
        </Footer>
      </Form>
    </Layer>
  )
});