const React                 = require('react');
const {withState}  = require('recompose');
const { Button, CheckBox, Layer, Form, Header, Heading, Paragraph, FormFields, Footer, Icons } = require('grommet');

const withRiskChecked = withState('riskChecked', 'setRiskChecked', false);

module.exports = withRiskChecked(({hidden, selectedBucket, riskChecked, setRiskChecked, onClose, onSubmit}) => {
  const _onSubmit = riskChecked ? (() => onSubmit(selectedBucket)) : null;

  return (
    <Layer onClose={onClose} align='right' closer={true} hidden={hidden}>
      <Form>
        <Header pad={{vertical: 'medium'}}><Heading>Remove bucket</Heading></Header>
        <FormFields>
          <Paragraph size='large'>
            All data inside bucket <strong>{selectedBucket}</strong> will be removed. This operation is irreversible.
          </Paragraph>
          <Paragraph style={{backgroundColor:'#faebcc', padding:'20px 10px'}} size='large' align='center'>
            <strong>Do you really want to delete this bucket?</strong>
          </Paragraph>

          <CheckBox label='Yes, I understand the risks.'
            onChange={(evt) => setRiskChecked(evt.target.checked)}
            checked={riskChecked}/>
        </FormFields>
        <Footer pad={{vertical:'medium'}} justify='between' align='center'>
          <Button icon={<Icons.Base.Trash />} onClick={_onSubmit} primary={true} label='Remove' />
          <Button onClick={onClose} plain={true} label='Cancel' />
        </Footer>
      </Form>
    </Layer>
  )
});